Received: from eggs.gnu.org ([2001:4830:134:3::10]:47256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVw8K-0007zp-Hd
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dVw8J-0002NS-L3
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 04:39:32 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-19-marcandre.lureau@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e94f793a-39cf-4862-278f-371deae7c42e@twiddle.net>
Date: Thu, 13 Jul 2017 22:39:24 -1000
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 18/29] piix: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>

On 07/13/2017 06:32 AM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau<marcandre.lureau@redhat.com>
> ---
>   hw/pci-host/piix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
