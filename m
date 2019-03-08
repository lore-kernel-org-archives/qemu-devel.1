Received: from eggs.gnu.org ([209.51.188.92]:49691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h261r-0006mW-N0
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:18:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1h261k-0005vl-Er
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:18:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1h261g-0005oU-Jb
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 22:18:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id x20so2158224qto.1
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 19:18:22 -0800 (PST)
Date: Thu, 7 Mar 2019 22:18:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190307221803-mutt-send-email-mst@kernel.org>
References: <20190307145839.13128-1-philmd@redhat.com>
	<a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7e51315-7b36-3bfd-9c78-296ba74614f7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 0/4] tests: Allow use of Ports bash and
 GNU sed extensions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Kamil Rytarowski <n54@gmx.com>, Brad Smith <brad@comstyle.com>

On Thu, Mar 07, 2019 at 04:27:36PM +0100, Thomas Huth wrote:
> On 07/03/2019 15.58, Philippe Mathieu-Daudé wrote:
> > Hi Thomas,
> 
> ? -----^
> 
> I could take the patch for tests/data/acpi/rebuild-expected-aml.sh
> through the qtests tree (if Michael or Igor don't want to take it), but
> the other patches are not related to qtests...
> 
>  Thomas

You can pick it up, sure

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
