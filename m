Received: from eggs.gnu.org ([2001:4830:134:3::10]:48080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNhK-0000fw-Nu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dlNhJ-0000iq-SW
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:07:30 -0400
Received: from hera.aquilenet.fr ([2a01:474::1]:37162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1dlNhJ-0000iU-LA
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 19:07:29 -0400
Date: Sat, 26 Aug 2017 01:07:19 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170825230719.7twl665s6iix6hyw@var.youpi.perso.aquilenet.fr>
References: <20170825223721.2052-1-samuel.thibault@ens-lyon.org>
	<20170825230504.4y4uychn3sqoljoc@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170825230504.4y4uychn3sqoljoc@var.youpi.perso.aquilenet.fr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: f4bug@amsat.org, ppandit@redhat.com, jan.kiszka@siemens.com, thuth@redhat.com, wjjzhang@tencent.com

Samuel Thibault, on sam. 26 ao=C3=BBt 2017 01:05:04 +0200, wrote:
> So Wjjzhang and PJP, can you confirm that this fixes your uses?

PJP, can you forward it to Wjjzhang?  I keep getting

<wjjzhang@tencent.com>: host cloudmx.qq.com[113.108.11.188] said: 550 Mai=
l
    content denied.
    http://ascloud.qq.com/cgi-bin/readtemplate?t=3Danti_spam_errors#n1000=
726 (in
    reply to end of DATA command)

Samuel
