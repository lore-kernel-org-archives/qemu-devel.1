Received: from eggs.gnu.org ([2001:4830:134:3::10]:54833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce1gV-0002t4-Of
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:40:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ce1gQ-0004c1-RY
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 10:39:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170210170910.8867-16-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
	<20170210170910.8867-16-berrange@redhat.com>
Date: Wed, 15 Feb 2017 16:39:52 +0100
Message-ID: <w51a89nqx87.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 15/18] iotests: enable tests 134 and 158
 to work with qcow (v1)
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

On Fri 10 Feb 2017 06:09:07 PM CET, Daniel P. Berrange wrote:
> The 138 and 158 iotests exercise the legacy qcow2 aes encryption
> code path and they work fine with qcow v1 too.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
