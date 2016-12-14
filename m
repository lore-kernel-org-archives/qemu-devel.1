Received: from eggs.gnu.org ([2001:4830:134:3::10]:60753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH2sa-0004sR-10
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:17:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH2sW-0001B1-1B
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:17:27 -0500
Received: from [2a03:4000:1::4e2f:c7ac:d] (port=55826 helo=mail.weilnetz.de)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cH2sV-00019K-Rp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 01:17:23 -0500
References: <20161213214917.6436-1-stefanha@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <cfe25220-8f20-b7ab-2c35-5fe6c0b12337@weilnetz.de>
Date: Wed, 14 Dec 2016 07:17:21 +0100
MIME-Version: 1.0
In-Reply-To: <20161213214917.6436-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] Update language files for QEMU 2.8.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org

On 12/13/16 22:49, Stefan Hajnoczi wrote:
> Update translation files (change created via 'make -C po update').
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  po/bg.po       | 40 ++++++++++++++++++++--------------------
>  po/de_DE.po    | 40 ++++++++++++++++++++++------------------
>  po/fr_FR.po    | 40 ++++++++++++++++++++++------------------
>  po/hu.po       | 40 ++++++++++++++++++++++------------------
>  po/it.po       | 40 ++++++++++++++++++++++------------------
>  po/messages.po | 42 +++++++++++++++++++++++-------------------
>  po/tr.po       | 40 ++++++++++++++++++++++------------------
>  po/zh_CN.po    | 40 ++++++++++++++++++++++------------------
>  8 files changed, 175 insertions(+), 147 deletions(-)
>

Reviewed-by: Stefan Weil <sw@weilnetz.de>

Thanks.

Stefan
