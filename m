Received: from eggs.gnu.org ([2001:4830:134:3::10]:52052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fq63V-0001bf-Mm
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1fq63R-0001Lb-LE
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:22:23 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:33738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1fq63M-0001IM-3B
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 20:22:18 -0400
Date: Thu, 16 Aug 2018 02:22:09 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180816002209.rgh4z5234eqi75wa@var.youpi.perso.aquilenet.fr>
References: <20180816001845.29052-1-andrew@andrewoates.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180816001845.29052-1-andrew@andrewoates.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] slirp: fix ICMP handling on macOS hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: andrew@andrewoates.com
Cc: peter.maydell@linaro.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org, Andrew Oates <aoates@google.com>

andrew@andrewoates.com, le mer. 15 ao=C3=BBt 2018 20:18:45 -0400, a ecrit=
:
> v4: drop packets that are too short for an IP header

Applied to my tree, thanks!

Samuel
