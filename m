Received: from eggs.gnu.org ([2001:4830:134:3::10]:41006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUtFo-0003gV-8X
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:22:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dUtFl-0002eF-4z
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:22:56 -0400
Received: from mail-wr0-f170.google.com ([209.85.128.170]:33837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dUtFk-0002e5-UY
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 07:22:53 -0400
Received: by mail-wr0-f170.google.com with SMTP id 77so178912225wrb.1
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 04:22:52 -0700 (PDT)
References: <20170629150308.22766-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <406b3f5e-34f1-f121-a85e-26ba57ab9923@redhat.com>
Date: Tue, 11 Jul 2017 13:22:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170629150308.22766-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] MAINTAINERS: update
 TCG/KVM/Xen/TCI/Unimplemented device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-trivial@nongnu.org

On 29/06/2017 17:03, Philippe Mathieu-Daudé wrote:
> As requested by Thomas Huth, I separated these patches from my previous series
> "removal of tci (tcg interpreter)".
> 
> TCG/KVM/Xen/TCI related files were moved in commits a9ded601..244f1441, update
> MAINTAINERS to match the new paths.
> 
> Also add an entry for the "Unimplemented" device and voluntary myself as
> reviewer.
> 
> Regards,
> 
> Phil.

Queued, thanks.

Paolo

> v2:
> - fix inaccurate Xen commit message (review feedback from Anthony PERARD)
> - add "Unimplemented" device
> 
> v1:
> - update TCG/KVM/Xen/TCI entries
> 
> Philippe Mathieu-Daudé (5):
>   MAINTAINERS: update TCG entries
>   MAINTAINERS: update KVM entries
>   MAINTAINERS: update Xen entries
>   MAINTAINERS: update TCI entry
>   MAINTAINERS: add entry for "Unimplemented" device
> 
>  MAINTAINERS | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
