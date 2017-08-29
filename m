Received: from eggs.gnu.org ([2001:4830:134:3::10]:54555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dmioU-0007HT-Dx
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dmioT-0001rA-EK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:52:26 -0400
Received: from research.iiit.ac.in ([196.12.53.8]:59336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chugh.ishani@research.iiit.ac.in>)
	id 1dmioS-0001l0-PK
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:52:25 -0400
Date: Tue, 29 Aug 2017 21:22:19 +0530 (IST)
From: Ishani <chugh.ishani@research.iiit.ac.in>
Message-ID: <1752389727.1286230.1504021939447.JavaMail.zimbra@research.iiit.ac.in>
In-Reply-To: <9bc66b3f-b17d-1093-1d20-5a515ea3fcd3@redhat.com>
References: <1504014481-7975-1-git-send-email-chugh.ishani@research.iiit.ac.in>
	<9bc66b3f-b17d-1093-1d20-5a515ea3fcd3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] QEMU Backup Tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow <jsnow@redhat.com>, stefanha <stefanha@redhat.com>

I apologize for it.
I have sent a new patch series by the same way again just now. Will correct in future patches.

Regards,
Ishani.

----- On Aug 29, 2017, at 8:19 PM, Eric Blake eblake@redhat.com wrote:

> On 08/29/2017 08:47 AM, Ishani Chugh wrote:
>> This patch series is intended to introduce QEMU Backup tool.
>> qemu-backup will be a command-line tool for performing full and
>> incremental disk backups on running VMs. It is intended as a
>> reference implementation for management stack and backup developers
>> to see QEMU's backup features in action.
>> This patch series contains three patches,
>>                1) QEMU Backup command line tool.
>>                2) Test for full backup.
>>                3) Manpage for the tool.
>> 
>> Ishani Chugh (3):
>>   backup: QEMU Backup Tool
>>   Test for full Backup
>>   Add manpage for QEMU Backup Tool
> 
> It looks like you have previously sent series by the same title:
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg03774.html
> 
> Please remember to use 'git send-email -v2' when sending version 2 of a
> series; it also helps to tell reviewers in the cover letter how version
> 2 differs from version 1.
> 
> More patch submission hints at
> http://wiki.qemu.org/Contribute/SubmitAPatch
> 
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
