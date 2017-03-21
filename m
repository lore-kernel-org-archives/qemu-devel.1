Received: from eggs.gnu.org ([2001:4830:134:3::10]:60388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE2e-00040m-2d
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cqE2d-0006Vy-6V
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 03:17:16 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1490014548-15083-1-git-send-email-armbru@redhat.com>
	<1490014548-15083-6-git-send-email-armbru@redhat.com>
	<c2110a8d-b4f8-3781-469c-59b99a062d6a@redhat.com>
Date: Tue, 21 Mar 2017 08:17:06 +0100
In-Reply-To: <c2110a8d-b4f8-3781-469c-59b99a062d6a@redhat.com> (Eric Blake's
	message of "Mon, 20 Mar 2017 15:03:37 -0500")
Message-ID: <87wpbjt7yl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.9 5/5] MAINTAINERS: Add myself for
 files I touched recently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>

Eric Blake <eblake@redhat.com> writes:

> On 03/20/2017 07:55 AM, Markus Armbruster wrote:
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  MAINTAINERS | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> By the way, where do we stand on the idea of having checkpatch.pl reject
> patches that introduce new files without mentioning a maintainer?

Stuck.  Thomas hasn't followed up on his RFC PATCH because he's afraid
of false positives.  I encouraged him to rescue at least "[RFC PATCH
4/5] checkpatch: emit a reminder about MAINTAINERS on file
add/move/delete", and I'm now encouraging him again.
