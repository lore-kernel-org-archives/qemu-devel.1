Received: from eggs.gnu.org ([2001:4830:134:3::10]:50773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqOO2-0001Yq-SH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:56:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fqONz-0006xc-PL
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:56:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fqONz-0006xO-Kq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 15:56:47 -0400
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1534409363.git.simon@ruderich.org>
	<4d2e5b229067980165bd2ff9cb84cffdb9949119.1534409363.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b03f0b8a-f679-67cb-fa86-c79dc31cb594@redhat.com>
Date: Thu, 16 Aug 2018 14:56:45 -0500
MIME-Version: 1.0
In-Reply-To: <4d2e5b229067980165bd2ff9cb84cffdb9949119.1534409363.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/7] cpus: correct coding style in
 qmp_memsave/qmp_pmemsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Simon Ruderich <simon@ruderich.org>, qemu-devel@nongnu.org
Cc: David Alan Gilbert <dgilbert@redhat.com>, Peter Crosthwaite <crosthwaitepeter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>

On 08/16/2018 04:01 AM, Simon Ruderich wrote:
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>   cpus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
