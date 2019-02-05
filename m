Received: from eggs.gnu.org ([209.51.188.92]:42539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5TK-0005LV-Gc
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gr5TI-0005nC-Hb
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:26 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:42920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gr5TG-0005km-IM
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 13:29:24 -0500
Date: Tue, 5 Feb 2019 20:29:09 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20190205182909.nnon2inyyuoy353r@function>
References: <20190205165927.26599-1-samuel.thibault@ens-lyon.org>
	<CAFEAcA8SsXDG7+vw63tYDjOvGsL+L5m9P9UhvHuttdS7kSJwdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8SsXDG7+vw63tYDjOvGsL+L5m9P9UhvHuttdS7kSJwdg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULLv2 00/32] More work towards libslirp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>

Peter Maydell, le mar. 05 f=C3=A9vr. 2019 18:24:45 +0000, a ecrit:
> /home/pm215/qemu/slirp/misc.c:166:5: error: unknown type name =E2=80=98=
QemuGSpawnFds=E2=80=99

D'oh...

Fixed in v3.

Samuel
