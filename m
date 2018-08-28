Received: from eggs.gnu.org ([2001:4830:134:3::10]:37677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuffV-0002Ld-IS
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fuffT-0005Rs-O9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:12:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47348 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fuffR-0005RF-Q9
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 11:12:30 -0400
References: <20180828120736.32323-1-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ddc2cd04-c323-da35-fb76-c8881726327f@redhat.com>
Date: Tue, 28 Aug 2018 10:12:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180828120736.32323-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qapi: A whitespace touch-up,
 and a doc update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com

On 08/28/2018 07:07 AM, Markus Armbruster wrote:
> Markus Armbruster (2):
>    qapi: Emit a blank line before dummy declaration
>    qapi: Update docs for generator changes since commit 9ee86b85267

Reviewed-by: Eric Blake <eblake@redhat.com>

(Nothing like my patch to the same file to make it obvious that we're 
not always remember to do this)

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
