Received: from eggs.gnu.org ([2001:4830:134:3::10]:41527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e0Sx6-0007Uz-3g
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e0Sx2-0002JY-V3
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1e0Sx2-0002H4-OR
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:46:04 -0400
References: <20171005203638.19255-1-ehabkost@redhat.com>
	<CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <49ba58a3-a15a-f188-cec6-f98985de1942@redhat.com>
Date: Fri, 6 Oct 2017 15:45:57 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-jBzTXWNrRCB8GXm2FcZdT3pPFZiGT6O6Oc8qpfSK_jA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/9] x86 and machine queue, 2017-10-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 06.10.2017 14:17, Peter Maydell wrote:
[...]
> 
> As an aside, these acpi tests are a bit noisy with
> V=1, especially the extra blank lines.
> 

FWIW, I suggested a patch here to fix that:

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05404.html

... but apparently Igor did not like it that much.

 Thomas
