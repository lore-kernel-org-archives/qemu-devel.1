Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHyv-0008KJ-Pz
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:46:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gNHyt-0001rp-3a
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:46:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:6092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gNHyq-0001n7-7m
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 08:46:49 -0500
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
	<cover.1542287931.git.simon@ruderich.org>
	<84e82ec58c7f280bab1e5cf8b0386033140aba2f.1542287931.git.simon@ruderich.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51b27b56-077a-3d28-e3b6-778dd1a22467@redhat.com>
Date: Thu, 15 Nov 2018 07:46:37 -0600
MIME-Version: 1.0
In-Reply-To: <84e82ec58c7f280bab1e5cf8b0386033140aba2f.1542287931.git.simon@ruderich.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 1/7] cpus: correct coding style in
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

On 11/15/18 7:22 AM, Simon Ruderich wrote:
> Signed-off-by: Simon Ruderich <simon@ruderich.org>
> ---
>   cpus.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
