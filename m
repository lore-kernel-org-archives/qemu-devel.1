Received: from eggs.gnu.org ([2001:4830:134:3::10]:40858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euJam-0001gp-Jk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:06:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1euJah-0007aG-O9
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:05:56 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41074 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1euJah-0007a3-KC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 10:05:51 -0500
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-3-marcandre.lureau@redhat.com>
	<FF72C7E4248F3C4E9BDF19D4918E90F249662416@shsmsx102.ccr.corp.intel.com>
	<CAJ+F1CJh9-8LSzVycnZXSj3MXPZM_TasYUFuYSTB4JzBC9tAYQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <ee1e2c90-c3c4-1a42-ad5d-809d6b43b730@redhat.com>
Date: Fri, 9 Mar 2018 16:05:36 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJh9-8LSzVycnZXSj3MXPZM_TasYUFuYSTB4JzBC9tAYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [edk2] [PATCH v2 2/8] SecurityPkg/Tcg2Pei: drop
 PeiReadOnlyVariable from Depex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Zhang, Chao B" <chao.b.zhang@intel.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "pjones@redhat.com" <pjones@redhat.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

On 03/09/18 14:05, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Thu, Mar 8, 2018 at 1:36 AM, Zhang, Chao B <chao.b.zhang@intel.com> =
wrote:
>> Hi Lureau:
>>    I think we can remove same dependency in TcgPei.
>>
>=20
> Thanks, feel free to explore that as a separate patch. This is out of
> scope to me.
>=20
>=20

I'll submit a patch for that later.

Thanks
Laszlo
