Received: from eggs.gnu.org ([2001:4830:134:3::10]:48549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPlHY-00054n-C1
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gPl3w-00034e-7N
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:14:21 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:41934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gPl3w-00033I-1H
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:14:16 -0500
Date: Thu, 22 Nov 2018 10:13:59 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181122091359.75kc7ekoo5p3ew72@function>
References: <20181121224220.10595-1-samuel.thibault@ens-lyon.org>
	<CAJ+F1CLYHOQ6E34EqfMN28SsJS4vMhYque2fBuauE=CL2V5SDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CLYHOQ6E34EqfMN28SsJS4vMhYque2fBuauE=CL2V5SDQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Mark debugging calls as unlikely
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, Zhang Chen <zhangckid@gmail.com>

Marc-Andr=C3=A9 Lureau, le jeu. 22 nov. 2018 11:13:51 +0400, a ecrit:
> With s/unlikely/G_UNLIKELY:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Right, pushed, thanks :)
