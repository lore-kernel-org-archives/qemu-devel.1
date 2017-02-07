Received: from eggs.gnu.org ([2001:4830:134:3::10]:43903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb3CX-0001bW-Jk
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cb3CS-0000Ow-Ld
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:40:45 -0500
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cb3CS-0000Ns-48
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 05:40:40 -0500
Received: by mail-lf0-x243.google.com with SMTP id h65so6268373lfi.3
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 02:40:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1486463022-4780-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71e68e8c-1a7f-2c93-f380-4da1e27090a0@redhat.com>
Date: Tue, 7 Feb 2017 11:40:36 +0100
MIME-Version: 1.0
In-Reply-To: <1486463022-4780-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu-web PATCH 0/2] Fix HTML issues discovered
 with the W3 HTML validator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org



On 07/02/2017 11:23, Thomas Huth wrote:
> The W3 HTML validator (https://validator.w3.org/) complains about
> missing "alt" attributes and a missing "</section>" tag for the
> new QEMU website. Here are two patches to fix the issues.
> 
> Thomas Huth (2):
>   Add missing HTML tag to close the screenshots section
>   Add "alt" attributes to the img tags
> 
>  _includes/screenshot.html | 2 +-
>  index.html                | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 

Applied, thanks! :)

Paolo
