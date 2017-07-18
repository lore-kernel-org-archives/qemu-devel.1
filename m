Received: from eggs.gnu.org ([2001:4830:134:3::10]:52188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUJN-0004jw-De
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:21:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dXUJM-0007Ic-My
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:21:21 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1500385286-21142-1-git-send-email-armbru@redhat.com>
	<1500385286-21142-4-git-send-email-armbru@redhat.com>
	<e6f2611e-ff9f-450c-a438-e740c2b57ece@redhat.com>
	<c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com>
Date: Tue, 18 Jul 2017 17:21:13 +0200
In-Reply-To: <c61aee5a-a094-50c3-67c3-c39e72095710@redhat.com> (Eric Blake's
	message of "Tue, 18 Jul 2017 09:54:09 -0500")
Message-ID: <87y3rlrct2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-2.10 03/10] qapi: Introduce a first
 class 'null' type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 07/18/2017 09:53 AM, Eric Blake wrote:
>> On 07/18/2017 08:41 AM, Markus Armbruster wrote:
>>> I expect the 'null' type to be useful mostly for members of alternate
>>> types.
>>>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>> 
>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Actually, do we need to update any qapi docs to mention the new builtin
> type?

Yes, we do.  I'll give it a shot.
