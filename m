Received: from eggs.gnu.org ([2001:4830:134:3::10]:38530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dECz5-0000uw-M0
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dECz4-0005m3-UV
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:00:43 -0400
Received: from mail-lf0-x22c.google.com ([2a00:1450:4010:c07::22c]:33388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dECz4-0005ls-NK
	for qemu-devel@nongnu.org; Fri, 26 May 2017 07:00:42 -0400
Received: by mail-lf0-x22c.google.com with SMTP id m18so4210758lfj.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 04:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-5-marcandre.lureau@redhat.com>
	<20170505235546.vawldizijy76ji34@var.youpi.perso.aquilenet.fr>
In-Reply-To: <20170505235546.vawldizijy76ji34@var.youpi.perso.aquilenet.fr>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 26 May 2017 11:00:30 +0000
Message-ID: <CAJ+F1CLS0ZpcMh6+eL4zy9JDKo-K9xr3-Lc+aae5a0V=xLGkjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/5] slirp: fix leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org

On Sat, May 6, 2017 at 3:56 AM Samuel Thibault <samuel.thibault@gnu.org>
wrote:

> Applied to my tree, thanks!
>
>
still not in tree, please remove the unnecessary 'if' before merging

thanks!
--=20
Marc-Andr=C3=A9 Lureau
