Received: from eggs.gnu.org ([2001:4830:134:3::10]:56525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJm19-00043U-4d
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:58:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eJm16-00085r-4F
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:58:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55254)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eJm15-00085V-Tu
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:58:04 -0500
References: <151134740734.552.186654908491769740@bafd83ae6430>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3d7b93b2-76b1-cfc4-f87b-8983a8439bb7@redhat.com>
Date: Tue, 28 Nov 2017 13:57:57 -0600
MIME-Version: 1.0
In-Reply-To: <151134740734.552.186654908491769740@bafd83ae6430>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on
 Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, yu.ning@linux.intel.com
Cc: famz@redhat.com, huth@tuxfamily.org, sw@weilnetz.de, yu.ning@intel.com, pbonzini@redhat.com, jsnow@redhat.com, patchew-devel@freelists.org

On 11/22/2017 04:43 AM, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH] Add a blog post about HAXM acceleration on Windows
> Type: series
> Message-id: 1511338200-20417-1-git-send-email-yu.ning@linux.intel.com

Just now noticing this, but it's impressive that:

> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> 73987e06df Add a blog post about HAXM acceleration on Windows

the patch even applied, even though it wasn't against qemu.git!  Is it 
possible to teach patchew to ignore patches against the website, as that 
is maintained in a separate repository?

> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
