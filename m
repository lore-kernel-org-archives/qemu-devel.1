Received: from eggs.gnu.org ([2001:4830:134:3::10]:45361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecCkA-0004vo-5o
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:08:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ecCk5-0006H3-8Z
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 11:08:46 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <6f573609-a04e-b3c5-6359-b6e08b138549@redhat.com>
References: <cover.1513342045.git.berto@igalia.com>
	<8525e16caa2fecac537aa62a449ea8626f5c7e36.1513342045.git.berto@igalia.com>
	<6f573609-a04e-b3c5-6359-b6e08b138549@redhat.com>
Date: Thu, 18 Jan 2018 17:08:36 +0100
Message-ID: <w51wp0fp2t7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 31/32] qcow2: Allow configuring the L2
 slice size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed 17 Jan 2018 12:18:25 AM CET, Eric Blake wrote:
> Is there a QMP counterpart to the command-line option?

Not in this revision, but I'll add one.

Berto
