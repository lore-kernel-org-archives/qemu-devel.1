Received: from eggs.gnu.org ([209.51.188.92]:56289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmDvR-0005Qk-75
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmDvQ-0001oG-EF
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:30:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmDvP-0001ma-Lu
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:30:20 -0500
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-2-kraxel@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a86bd73d-f12e-2b3e-fe56-b5d3c2936b3a@redhat.com>
Date: Wed, 23 Jan 2019 09:30:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190123080005.31078-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] audio: use pkg-config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

On 2019-01-23 09:00, Gerd Hoffmann wrote:
> Use pkg-config to probe for alsa and pulseaudio.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 39 +++++++++++++--------------------------
>  1 file changed, 13 insertions(+), 26 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
