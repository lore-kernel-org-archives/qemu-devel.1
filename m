Received: from eggs.gnu.org ([2001:4830:134:3::10]:41211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gEXw1-0004cs-SN
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gEXvx-0002gR-PD
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:59:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gEXvx-0002eb-Gy
	for qemu-devel@nongnu.org; Mon, 22 Oct 2018 06:59:41 -0400
References: <20181022084824.555-1-maozhongyi@cmss.chinamobile.com>
	<20181022084824.555-3-maozhongyi@cmss.chinamobile.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c3308f3b-50c4-2b15-f117-816ba326ef5f@redhat.com>
Date: Mon, 22 Oct 2018 11:59:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181022084824.555-3-maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] po/Makefile: Modern shell scripting
 (use $() instead of ``)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, peter.maydell@linaro.org, sw@weilnetz.de

On 2018-10-22 09:48, Mao Zhongyi wrote:
> Various shell files contain a mix between obsolete ``
> and modern $(); It would be nice to convert to using $()
> everywhere.
> 
> Cc: philmd@redhat.com
> Cc: peter.maydell@linaro.org
> Cc: thuth@redhat.com
> Cc: sw@weilnetz.de
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

That last line should be "Reviewed-by:" instead - but that can be fixed
when the patch is picked up, no need to resend just because of this nit.

 Thomas
