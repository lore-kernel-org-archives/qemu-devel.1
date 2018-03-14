Received: from eggs.gnu.org ([2001:4830:134:3::10]:39845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewAY7-00064e-5j
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:50:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ewAY4-00075b-4T
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 13:50:51 -0400
References: <20180314173213.18563-1-kwolf@redhat.com>
	<20180314173213.18563-6-kwolf@redhat.com>
	<1308d507-b808-776d-96ec-8314c4e0594a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f04908d0-b288-eab0-e57b-676f837c700c@redhat.com>
Date: Wed, 14 Mar 2018 12:50:39 -0500
MIME-Version: 1.0
In-Reply-To: <1308d507-b808-776d-96ec-8314c4e0594a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] tests/multiboot: Add .gitignore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: jack.schwartz@oracle.com, qemu-stable@nongnu.org, anatol.pomozov@gmail.com, ppandit@redhat.com

On 03/14/2018 12:43 PM, Eric Blake wrote:
> On 03/14/2018 12:32 PM, Kevin Wolf wrote:
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>> ---
>> =C2=A0 tests/multiboot/.gitignore | 3 +++
>> =C2=A0 1 file changed, 3 insertions(+)
>> =C2=A0 create mode 100644 tests/multiboot/.gitignore
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Huh - and I even proposed something similar a while back:
https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg00305.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
