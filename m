Received: from eggs.gnu.org ([2001:4830:134:3::10]:34043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9quH-0000IX-Fh
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9quE-0002Ia-A4
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 08:14:33 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181005234023.8104-8-mreitz@redhat.com>
References: <20181005234023.8104-1-mreitz@redhat.com>
	<20181005234023.8104-8-mreitz@redhat.com>
Date: Tue, 09 Oct 2018 14:14:13 +0200
Message-ID: <w51y3b78gh6.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v11 07/31] iotests.py: Add node_info()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

On Sat 06 Oct 2018 01:39:59 AM CEST, Max Reitz wrote:
> This function queries a node; since we cannot do that right now, it
> executes query-named-block-nodes and returns the matching node's object.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
