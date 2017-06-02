Received: from eggs.gnu.org ([2001:4830:134:3::10]:59757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dGi1T-0001HM-V3
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:33:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dGi1P-0005Gd-VK
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:33:31 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170601172734.9039-20-berrange@redhat.com>
References: <20170601172734.9039-1-berrange@redhat.com>
	<20170601172734.9039-20-berrange@redhat.com>
Date: Fri, 02 Jun 2017 10:32:49 +0200
Message-ID: <w51vaoeiyby.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 19/20] qcow2: report encryption specific
 image information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Thu 01 Jun 2017 07:27:33 PM CEST, Daniel P. Berrange wrote:
> Currently 'qemu-img info' reports a simple "encrypted: yes"
> field. This is not very useful now that qcow2 can support
> multiple encryption formats. Users want to know which format
> is in use and some data related to it.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
