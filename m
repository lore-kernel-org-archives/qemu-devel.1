Received: from eggs.gnu.org ([2001:4830:134:3::10]:57938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g86oA-0003tY-Eg
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g86o9-00018k-IJ
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 12:49:02 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-4-crosa@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd70878f-b7d8-b7aa-6227-f53ddfbe24e6@redhat.com>
Date: Thu, 4 Oct 2018 11:48:52 -0500
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: make 218 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 10/4/18 11:18 AM, Cleber Rosa wrote:
> Commit 990dc39c made all tests executable at the time, but 218 came in
> later, and missing those permissions.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/qemu-iotests/218 | 0
>   1 file changed, 0 insertions(+), 0 deletions(-)
>   mode change 100644 => 100755 tests/qemu-iotests/218
> 
> diff --git a/tests/qemu-iotests/218 b/tests/qemu-iotests/218
> old mode 100644
> new mode 100755

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
