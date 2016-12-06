Received: from eggs.gnu.org ([2001:4830:134:3::10]:51738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEIRd-0006bZ-Li
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cEIRZ-000859-Mo
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:18:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1cEIRZ-00084x-GA
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 11:18:13 -0500
References: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e8c1ed6f-fc4b-2093-60d8-5a2fb4f22e5e@redhat.com>
Date: Tue, 6 Dec 2016 11:18:10 -0500
MIME-Version: 1.0
In-Reply-To: <2011630530.2430235.1481039230635.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] ui/egl-helpers.c license and reuse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>, Qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Gonglei <arei.gonglei@huawei.com>, Cole Robinson <crobinso@redhat.com>



On 12/06/2016 10:47 AM, Frediano Ziglio wrote:
> Hi,
>   I work in the SPICE team (www.spice-space.org). I'd like to reuse some code from
> this file for some test for our project. The license of the 2 projects are a bit
> different (GPL2 against LGPL2) so in theory I couldn't do it.
> The code is mainly doing EGL initialization.
> Could I obtain a dispensation to reuse to code as LGPL2 ?
> Alternatively where can I get similar code with compatible LGPL2 license ?
> 
> Regards,
>   Frediano
> 

"IANAL,"

Looks like the file was authored by four people with no explicit
license, so it defaulted to GPL2.

Cole Robinson, Gerd Hoffman, Gonglei, and Peter Maydell.

Maybe you can get explicit permission from these four.

--js
