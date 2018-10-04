Received: from eggs.gnu.org ([2001:4830:134:3::10]:59883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86t6-0007St-GA
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:54:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1g86t5-0000Sf-OP
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:54:08 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-10-crosa@redhat.com>
	<18373d58-eeac-4acd-b112-41c8c47cd605@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <599035ef-1f6a-b93d-dbab-b250ec63f5b5@redhat.com>
Date: Thu, 4 Oct 2018 12:53:59 -0400
MIME-Version: 1.0
In-Reply-To: <18373d58-eeac-4acd-b112-41c8c47cd605@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/10] scripts/qemu.py: use a more
 consistent docstring style
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>



On 10/4/18 12:50 PM, Eric Blake wrote:
> On 10/4/18 11:18 AM, Cleber Rosa wrote:
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>> =C2=A0 dtc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 2 +-
>> =C2=A0 scripts/qemu.py | 65 +++++++++++++++++++++++++++++++-----------=
-------
>> =C2=A0 2 files changed, 42 insertions(+), 25 deletions(-)
>>
>> diff --git a/dtc b/dtc
>> index 88f18909db..e54388015a 160000
>> --- a/dtc
>> +++ b/dtc
>> @@ -1 +1 @@
>> -Subproject commit 88f18909db731a627456f26d779445f84e449536
>> +Subproject commit e54388015af1fb4bf04d0bca99caba1074d9cc42
>=20
> The submodule change was probably unintended.
>=20

Yep, my bad.
