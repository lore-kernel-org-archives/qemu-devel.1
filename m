Received: from eggs.gnu.org ([2001:4830:134:3::10]:32824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmMDm-0003no-BX
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1dmMDi-0000Zc-Em
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 11:45:02 -0400
Date: Mon, 28 Aug 2017 17:44:55 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170828154455.7wsuweeny4mt2lc3@var.youpi.perso.aquilenet.fr>
References: <20170827230506.12683-1-samuel.thibault@ens-lyon.org>
	<20170827230506.12683-2-samuel.thibault@ens-lyon.org>
	<c95c64ee-f9c7-7e58-a4fd-aff76b78a82c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c95c64ee-f9c7-7e58-a4fd-aff76b78a82c@redhat.com>
Subject: Re: [Qemu-devel] [PULL 1/1] slirp: fix clearing ifq_so from pending
 packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, jan.kiszka@siemens.com, qemu-stable <qemu-stable@nongnu.org>

Hello,

Eric Blake, on lun. 28 août 2017 10:43:48 -0500, wrote:
> This is a pull request, but missed 2.10-rc4, which makes it really hard
> to justify for inclusion in 2.10 proper.  Is it okay that this doesn't
> go in until 2.11?

Well, AIUI we have been living with the issue for years (decades?), so
it can probably wait a bit more :)

Samuel
