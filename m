Received: from eggs.gnu.org ([2001:4830:134:3::10]:60955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGdV-0006ul-Gl
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gVGdR-00050n-Gu
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gVGdP-0004pn-EE
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 08:57:41 -0500
References: <1543851204-41186-1-git-send-email-pbonzini@redhat.com>
	<1543851204-41186-20-git-send-email-pbonzini@redhat.com>
	<d412f01a-2b40-8ecd-b2f1-53119b9e7ce0@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <81d02ce0-46df-789c-99c5-7afd3077e563@redhat.com>
Date: Fri, 7 Dec 2018 14:57:33 +0100
MIME-Version: 1.0
In-Reply-To: <d412f01a-2b40-8ecd-b2f1-53119b9e7ce0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/71] tests: qgraph API for the qtest
 driver framework
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <laurent@vivier.eu>

On 07/12/18 13:42, Thomas Huth wrote:
> The license statement is inaccurate. There is no "GNU *Lesser* General
> Public License version *2*" ... so I'm assuming you wanted to use one of
> these two options:
> 
> - GNU Library General Public License, version 2.0
> - GNU Lesser General Public License, version 2.1
> 
> I assume you wanted to use the latter, so please replace the "2" with
> "2.1" in all license statements here.

Yes, I will change it to Lesser GPL 2.1.

Paolo
