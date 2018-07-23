Received: from eggs.gnu.org ([2001:4830:134:3::10]:53174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhWqq-000869-4V
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:09:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fhWql-0003gD-5v
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 05:09:56 -0400
References: <20180720212509.18339-1-sw@weilnetz.de>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9b0d2a44-5a72-b4e8-ef0f-2f7ee3e079e6@redhat.com>
Date: Mon, 23 Jul 2018 11:09:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180720212509.18339-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 for-3.0] po: Don't include comments with
 location
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, QEMU Developer <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?B?w4Frb3MgS292w6Fjcw==?= <akoskovacs@gmx.com>, Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Alexander Shopov <ash@kambanaria.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?B?T3phbiDDh2HEn2xheWFu?= <ozancag@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>

On 20.07.2018 23:25, Stefan Weil wrote:
> Those comments change often when ui/gtk.c is changed and are not
> really useful.
> 
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
> 
> CC'ing all translators because of the new string which still needs
> translations.
> 
> v2: Only automatically created content, no new German translation.
> 
> Regards
> Stefan
> 
>  po/Makefile    |  2 +-
>  po/bg.po       | 23 ++++-------------------
>  po/de_DE.po    | 23 ++++-------------------
>  po/fr_FR.po    | 23 ++++-------------------
>  po/hu.po       | 23 ++++-------------------
>  po/it.po       | 23 ++++-------------------
>  po/messages.po | 25 +++++--------------------
>  po/tr.po       | 23 ++++-------------------
>  po/zh_CN.po    | 23 ++++-------------------
>  9 files changed, 34 insertions(+), 154 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
