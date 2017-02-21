Received: from eggs.gnu.org ([2001:4830:134:3::10]:57990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBJL-0005lL-5X
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:21:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cgBJH-0006Ky-5G
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:20:59 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170221115512.21918-17-berrange@redhat.com>
References: <20170221115512.21918-1-berrange@redhat.com>
	<20170221115512.21918-17-berrange@redhat.com>
Date: Tue, 21 Feb 2017 15:20:43 +0100
Message-ID: <w51efyrbp6s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 16/18] block: rip out all traces of
 password prompting
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

On Tue 21 Feb 2017 12:55:10 PM CET, Daniel P. Berrange wrote:
> Now that qcow & qcow2 are wired up to get encryption keys
> via the QCryptoSecret object, nothing is relying on the
> interactive prompting for passwords. All the code related
> to password prompting can thus be ripped out.
>
> Reviewed-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
