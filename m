Received: from eggs.gnu.org ([2001:4830:134:3::10]:52612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm3i-0002Km-Bp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:41:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eqm3h-0003Yf-EA
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 15:41:10 -0500
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-21-jsnow@redhat.com>
	<b281a542-743e-1a92-3434-2c80fede86af@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cb0b8241-52e9-be5a-d6de-1cb86edb5ead@redhat.com>
Date: Tue, 27 Feb 2018 15:41:06 -0500
MIME-Version: 1.0
In-Reply-To: <b281a542-743e-1a92-3434-2c80fede86af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 20/21] iotests: test manual job dismissal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org



On 02/27/2018 03:21 PM, Eric Blake wrote:
> On 02/23/2018 05:51 PM, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/056=C2=A0=C2=A0=C2=A0=C2=A0 | 195
>> +++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 tests/qemu-iotests/056.out |=C2=A0=C2=A0 4 +-
>> =C2=A0 2 files changed, 197 insertions(+), 2 deletions(-)
>>
>=20
> I'm not sure if this covers everything in the series, but it looks like

It definitely doesn't!

> a reasonable expansion and hits a lot of the highlights.=C2=A0 At any r=
ate,
> it's always better to add tests, and the test passing is a good bet tha=
t
> the new code will be harder to regress.
>=20

More to follow, but I was afraid of wasting time if this series didn't
look on the whole serviceable.

I'll probably focus efforts on expanding blockjob-txn and blockjob unit
tests.

> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
