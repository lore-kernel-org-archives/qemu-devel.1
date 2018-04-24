Received: from eggs.gnu.org ([2001:4830:134:3::10]:52946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fB3K1-0008WH-Pq
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fB3K0-0003YH-SY
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:09:49 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:40213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fB3K0-0003Y1-Ni
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 15:09:48 -0400
Received: by mail-ot0-x241.google.com with SMTP id h8-v6so22544760otj.7
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 12:09:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1524592709-6553-10-git-send-email-ian.jackson@eu.citrix.com>
References: <1524592709-6553-1-git-send-email-ian.jackson@eu.citrix.com>
	<1524592709-6553-10-git-send-email-ian.jackson@eu.citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Apr 2018 20:09:27 +0100
Message-ID: <CAFEAcA_6+o=r4VPr69iJc7x19NZJR8Tow1QkTuSyyWTDGPuT_Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 09/16] os-posix: cleanup: Replace fprintfs
 with error_report in change_process_uid
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ian Jackson <ian.jackson@eu.citrix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On 24 April 2018 at 18:58, Ian Jackson <ian.jackson@eu.citrix.com> wrote:
> I'm going to be editing this function and it makes sense to clean up
> this style problem in advance.
>
> Signed-off-by: Ian Jackson <Ian.Jackson@eu.citrix.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Markus Armbruster <armbru@redhat.com>
> CC: Daniel P. Berrange <berrange@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
