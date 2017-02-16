Received: from eggs.gnu.org ([2001:4830:134:3::10]:40372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ceMTD-000438-12
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ceMT8-0006mn-6t
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:51:39 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-15-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-15-berrange@redhat.com>
Date: Thu, 16 Feb 2017 14:51:31 +0100
Message-ID: <w5137feckgs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 14/18] qcow2: add iotests to cover LUKS
 encryption support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

On Fri 10 Feb 2017 06:09:06 PM CET, Daniel P. Berrange wrote:
> This extends the 087 iotest to cover LUKS encryption when doing
> blockdev-add.
>
> Two further tests are added to validate read/write of LUKS
> encrypted images with a single file and with a backing file.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
