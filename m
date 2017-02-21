Received: from eggs.gnu.org ([2001:4830:134:3::10]:36859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgAZ8-0003cQ-AN
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:33:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgAZ5-0001IY-7m
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:33:14 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-13-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-13-berrange@redhat.com>
Date: Tue, 21 Feb 2017 14:33:00 +0100
Message-ID: <w51k28jbreb.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 12/18] qcow2: extend specification to
 cover LUKS encryption
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

On Tue 21 Feb 2017 12:55:06 PM CET, Daniel P. Berrange wrote:
> Update the qcow2 specification to describe how the LUKS header is
> placed inside a qcow2 file, when using LUKS encryption for the
> qcow2 payload instead of the legacy AES-CBC encryption
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
