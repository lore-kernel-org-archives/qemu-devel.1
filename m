Received: from eggs.gnu.org ([2001:4830:134:3::10]:34595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1d6Hao-0006G7-WA
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1d6Hal-00079N-1C
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:18:54 -0400
Received: from mail-ua0-x244.google.com ([2607:f8b0:400c:c08::244]:36673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1d6Hak-000796-Px
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:18:50 -0400
Received: by mail-ua0-x244.google.com with SMTP id x28so1227105uab.3
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 07:18:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1493299264-10669-1-git-send-email-daniel@daynix.com>
References: <1493299264-10669-1-git-send-email-daniel@daynix.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 4 May 2017 17:18:49 +0300
Message-ID: <CAKPgXcG3S7U5_XXK+ch6jrnTqV4ZZ0oVhU==mpEeKyK3LsbYPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 0/1] qga-win: fix installation on
 localized Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Rempel <daniel@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Acked-by: Sameeh Jubran <sameeh@daynix.com>

On Thu, Apr 27, 2017 at 4:21 PM, Daniel Rempel <daniel@daynix.com> wrote:

> Second version of the patch. Cleaned the code a bit.
>
> Daniel Rempel (1):
>   qga-win: fix installation on localized windows
>
>  qga/vss-win32/install.cpp | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> --
> 2.9.3
>
>
>


-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
