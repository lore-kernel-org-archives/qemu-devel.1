Received: from eggs.gnu.org ([2001:4830:134:3::10]:40565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5OU-0006f0-Q0
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ga5OU-0005wo-2F
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 15:58:10 -0500
References: <20181220022952.20493-1-jsnow@redhat.com>
	<20181220022952.20493-12-jsnow@redhat.com>
	<ca1a1d6f-495a-ebc6-353e-77769a52fe29@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1519a7a1-5dee-6b39-8daa-0a80ff32fa2d@redhat.com>
Date: Thu, 20 Dec 2018 15:58:03 -0500
MIME-Version: 1.0
In-Reply-To: <ca1a1d6f-495a-ebc6-353e-77769a52fe29@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 11/11] iotests: add iotest 236 for
 testing bitmap merge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>



On 12/19/18 10:02 PM, Eric Blake wrote:
> On 12/19/18 8:29 PM, John Snow wrote:
>> New interface, new smoke test.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 tests/qemu-iotests/236=C2=A0=C2=A0=C2=A0=C2=A0 | 161 ++++++++++=
+++++++
>> =C2=A0 tests/qemu-iotests/236.out | 351 ++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 tests/qemu-iotests/group=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 3 files changed, 513 insertions(+)
>> =C2=A0 create mode 100755 tests/qemu-iotests/236
>> =C2=A0 create mode 100644 tests/qemu-iotests/236.out
>>
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> (and glad that my insistence on beefing up the test has caught bugs)
>=20

Me too. Sorry to have been lazy about it. Your suggestions are always
worth following.

--js
