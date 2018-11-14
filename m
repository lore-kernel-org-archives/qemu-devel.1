Received: from eggs.gnu.org ([2001:4830:134:3::10]:36196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gMjGa-0006m8-Jw
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gMjGR-0005XM-2V
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:42:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:58162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gMjGN-0005Mj-U5
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 19:42:37 -0500
Date: Wed, 14 Nov 2018 01:42:23 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181114004223.heerwwlhqsyrwa22@function>
References: <20181113070320.16147-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181113070320.16147-1-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] slirp: add tftp tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>

Gerd Hoffmann, le mar. 13 nov. 2018 08:03:20 +0100, a ecrit:
> Useful when debugging pxeboot, to see what the guest tries to do.

Applied to my tree, thanks!

Samuel
