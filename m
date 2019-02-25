Received: from eggs.gnu.org ([209.51.188.92]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyJ2i-0001Gd-EA
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyJ2h-0002MO-SM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:48 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyJ2h-0002Lf-LM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 11:23:47 -0500
Received: by mail-wm1-f52.google.com with SMTP id v26so8662382wmh.3
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 08:23:46 -0800 (PST)
References: <20190221173326.31874-1-mst@redhat.com>
	<CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
	<20190222105159-mutt-send-email-mst@kernel.org>
	<20190223193335-mutt-send-email-mst@kernel.org>
	<CAFEAcA87W8VdNSoROcn_wV2UnOQpP7qaLgok6RsbsPLhVvnZ1w@mail.gmail.com>
	<20190224114135-mutt-send-email-mst@kernel.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6079ace1-7e96-7f30-9f45-6e79c8137fb9@redhat.com>
Date: Mon, 25 Feb 2019 17:23:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190224114135-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>

On 2/24/19 5:41 PM, Michael S. Tsirkin wrote:
> On Sun, Feb 24, 2019 at 10:21:52AM +0000, Peter Maydell wrote:
>> In general I prefer it if you just re-send the cover-letter
>> email as a v2 rather than informally asking for a retry: that
>> guarantees I'll see it and automatically makes it appear
>> in my list of things to process. You don't need to
>> resend all the individual patchmails if the change was
>> minor.

I appreciate what some maintainers do (such Paolo/Richard):
sending the cover + the patches changed, because we can review the
updated patch on the list and tag/remove the patch from the mail queue,
rather than after it was merged via the git tree (if smth was wrong, it
is too late).

>>
>> thanks
>> -- PMM
> 
> Good to know.
> 
