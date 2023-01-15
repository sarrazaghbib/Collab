const express = require('express');
const { GetMembers,CreateMember,deleteMember } = require('../Controllers/MemberController');

const router = express.Router();
router.get('/members/:id', GetMembers);
router.delete('/members/:id', deleteMember);
router.post('/members/:owner_id',CreateMember);

module.exports = {
    routes: router
}