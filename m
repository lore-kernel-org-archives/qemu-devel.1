Received: from eggs.gnu.org ([2001:4830:134:3::10]:59220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dyzQ2-0000aC-Ni
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:02:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dyzPx-0008KN-Bd
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:01:54 -0400
Received: from mail-yw0-x243.google.com ([2607:f8b0:4002:c05::243]:34731)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dyzPx-0008KC-64
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 08:01:49 -0400
Received: by mail-yw0-x243.google.com with SMTP id v72so3397884ywa.1
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 05:01:49 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1506935300-132598-1-git-send-email-imammedo@redhat.com>
	<1506935300-132598-4-git-send-email-imammedo@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6de7a92d-f10c-af57-ade5-19edf11bc3ef@twiddle.net>
Date: Mon, 2 Oct 2017 05:01:46 -0700
MIME-Version: 1.0
In-Reply-To: <1506935300-132598-4-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 03/38] alpha: use generic cpu_model parsing
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
List-ID: <qemu-devel.nongnu.org>

On 10/02/2017 02:07 AM, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: rth@twiddle.net
> ---
>  hw/alpha/dp264.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Richard Henderson <rth@twiddle.net>


r~
