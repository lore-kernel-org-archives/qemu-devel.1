Received: from eggs.gnu.org ([2001:4830:134:3::10]:56431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbX4-0004HO-6X
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:27:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gRbWz-0001lQ-7D
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:27:58 -0500
References: <1542891760-13937-1-git-send-email-thuth@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <4ee473b2-58a6-746c-56d0-533a17114181@vivier.eu>
Date: Tue, 27 Nov 2018 12:27:36 +0100
MIME-Version: 1.0
In-Reply-To: <1542891760-13937-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] MAINTAINERS: Add missing
 hw/pci-host entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>

On 22/11/2018 14:02, Thomas Huth wrote:
> Bonito belongs to Fulong-2E, Sabre belongs to Sun4u, and Mac-Newworld
> and Mips-Boston were missing the header files.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
