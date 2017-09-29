Received: from eggs.gnu.org ([2001:4830:134:3::10]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxsJU-0002bG-5t
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxsJP-0000NU-5p
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:14:32 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:47388)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dxsJO-0000NK-W4
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 06:14:27 -0400
References: <1506677707-2758-1-git-send-email-jiang.biao2@zte.com.cn>
	<5e146f0b-3c7c-b0a7-cea2-1d20bfcfc2d2@amsat.org>
From: Yongbok Kim <yongbok.kim@imgtec.com>
Message-ID: <b70bb6ae-9cac-06e6-c65e-1fd11b8308db@imgtec.com>
Date: Fri, 29 Sep 2017 11:14:25 +0100
MIME-Version: 1.0
In-Reply-To: <5e146f0b-3c7c-b0a7-cea2-1d20bfcfc2d2@amsat.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/mips: remove commented out codes in
 translate.c
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jiang Biao <jiang.biao2@zte.com.cn>, aurelien@aurel32.net
Cc: zhong.weidong@zte.com.cn, qemu-devel@nongnu.org
List-ID: <qemu-devel.nongnu.org>



On 29/09/2017 10:58, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Jiang,
>=20
> I'm not sure it is really helpful to remove those comment, they are her=
e as
> debt to the project, reminding what should be implemented.
>=20
> Are you proposing to accept this instructions will never get implemente=
d?
>=20
> Regards,
>=20
> Phil.
>=20

Hi Phil,

The commented codes are all trivial. When the time we implement those
features it is merely copy & paste from the specification. I don't think
there is much harm to remove the comments.
Besides there is TODO file in the same directory but that has not been
updated for a while, perhaps updating the file is much relevant with this
patch.

Regards,
Yongbok
