Received: from eggs.gnu.org ([2001:4830:134:3::10]:55714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDBEY-0006kb-KC
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:56:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dDBEW-0003Mo-3D
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:56:26 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1494322876-28843-1-git-send-email-armbru@redhat.com>
	<ea74cfd3-9009-e99d-8f18-8edc9c0441c2@redhat.com>
	<87zie3byk6.fsf@dusky.pond.sub.org>
Date: Tue, 23 May 2017 16:56:18 +0200
In-Reply-To: <87zie3byk6.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Tue, 23 May 2017 13:30:17 +0200")
Message-ID: <87h90b39m5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 0/2] docs: Minor updates around ide-drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> On 05/09/2017 05:41 AM, Markus Armbruster wrote:
>>> Markus Armbruster (2):
>>>   docs qemu-doc: Avoid ide-drive, it's deprecated
>>>   docs/qdev-device-use.txt: update section Default Devices
>>> 
>>>  docs/bootindex.txt       |  2 +-
>>>  docs/qdev-device-use.txt | 13 +++++++------
>>>  qemu-options.hx          |  2 +-
>>>  3 files changed, 9 insertions(+), 8 deletions(-)
>>> 
>>
>> Shame on me for not noticing, but thank you.
>>
>> Acked-by: John Snow <jsnow@redhat.com>
>
> Thanks!
>
> The canonical path is through your tree, but I could stick it into a
> miscellaneous pull request if you like.

Nevermind, qemu-trivial picked it up.
