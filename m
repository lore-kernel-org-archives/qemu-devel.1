Received: from eggs.gnu.org ([2001:4830:134:3::10]:42116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1euHij-000132-Gi
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1euHii-0000QP-Pk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:06:01 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:35129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1euHii-0000OJ-IO
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:06:00 -0500
Received: by mail-wm0-x22d.google.com with SMTP id x7so3797965wmc.0
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:06:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <FF72C7E4248F3C4E9BDF19D4918E90F249662416@shsmsx102.ccr.corp.intel.com>
References: <20180307155746.18526-1-marcandre.lureau@redhat.com>
	<20180307155746.18526-3-marcandre.lureau@redhat.com>
	<FF72C7E4248F3C4E9BDF19D4918E90F249662416@shsmsx102.ccr.corp.intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 9 Mar 2018 14:05:58 +0100
Message-ID: <CAJ+F1CJh9-8LSzVycnZXSj3MXPZM_TasYUFuYSTB4JzBC9tAYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Zhang, Chao B" <chao.b.zhang@intel.com>
Cc: "edk2-devel@lists.01.org" <edk2-devel@lists.01.org>, "lersek@redhat.com" <lersek@redhat.com>, "pjones@redhat.com" <pjones@redhat.com>, "Yao,
	Jiewen" <jiewen.yao@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "javierm@redhat.com" <javierm@redhat.com>

Hi

On Thu, Mar 8, 2018 at 1:36 AM, Zhang, Chao B <chao.b.zhang@intel.com> wrot=
e:
> Hi Lureau:
>    I think we can remove same dependency in TcgPei.
>

Thanks, feel free to explore that as a separate patch. This is out of
scope to me.


--=20
Marc-Andr=C3=A9 Lureau
