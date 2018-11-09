Received: from eggs.gnu.org ([2001:4830:134:3::10]:39053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gL9lP-0005vp-Nt
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gL9lL-0003bz-Mg
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60722)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gL9lL-0003a9-FR
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 11:36:03 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 94CDD30821ED
	for <qemu-devel@nongnu.org>; Fri,  9 Nov 2018 16:36:02 +0000 (UTC)
References: <20181109141447.13101-1-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <afc399ab-066b-a6e4-62d9-9e23bc83fcf2@redhat.com>
Date: Fri, 9 Nov 2018 10:36:01 -0600
MIME-Version: 1.0
In-Reply-To: <20181109141447.13101-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/bt: drop bluetooth keyboard emulation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 11/9/18 8:14 AM, Gerd Hoffmann wrote:
> Broken (segfaultson first keypress) and appearently unused.

s/segfaultson/segfaults on/, s/appearently/apparently/

Also, trailing '.' in the subject line is unusual

> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
