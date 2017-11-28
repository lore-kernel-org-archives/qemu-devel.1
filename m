Received: from eggs.gnu.org ([2001:4830:134:3::10]:52252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJiwn-0001Ov-JA
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:41:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJiwj-0005kn-1V
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:41:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59255)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJiwi-0005kY-RO
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 11:41:20 -0500
References: <20171128161529.3025-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a1b73cae-5972-4503-619e-f91bacfd6112@redhat.com>
Date: Tue, 28 Nov 2017 10:41:16 -0600
MIME-Version: 1.0
In-Reply-To: <20171128161529.3025-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-options: document missing memory
 backend items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Hu Tao <hutao@cn.fujitsu.com>

On 11/28/2017 10:15 AM, Stefan Hajnoczi wrote:
> This series adds several missing items to the QEMU documentation on memory
> backends.
> 
> Stefan Hajnoczi (2):
>    qemu-options: document missing memory-backend-file options
>    qemu-options: document memory-backend-ram
> 
>   qemu-options.hx | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 48 insertions(+), 7 deletions(-)

As documentation, it could still make it into 2.11, although you're 
cutting it close.  It's also fine if it waits for 2.12.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
