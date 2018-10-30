Received: from eggs.gnu.org ([2001:4830:134:3::10]:56564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHS6k-0007vj-7X
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHS6g-0008Db-TC
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 07:22:50 -0400
References: <20181030111348.14713-1-kraxel@redhat.com>
	<20181030111348.14713-4-kraxel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dace73c3-5706-915c-32e9-08192634696e@redhat.com>
Date: Tue, 30 Oct 2018 12:22:23 +0100
MIME-Version: 1.0
In-Reply-To: <20181030111348.14713-4-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] tag cirrus as obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>

On 30/10/2018 12:13, Gerd Hoffmann wrote:
> +    dc->supported.reason = "use \"-vga std\" instead, see "
> +        "https://www.kraxel.org/blog/2014/10/qemu-using-cirrus-considered-harmful/";

Any chance you could update that blog post for the last 4 years and post
it on qemu.org?

Thanks,

Paolo
