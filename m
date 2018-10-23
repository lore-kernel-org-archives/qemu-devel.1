Received: from eggs.gnu.org ([2001:4830:134:3::10]:47269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF27Y-0005Ta-5M
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gF27V-0005xu-FO
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:13:39 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44579)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gF27N-0005jt-3T
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 15:13:32 -0400
Received: by mail-oi1-x243.google.com with SMTP id u74-v6so2046810oia.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 12:13:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181023190843.GB8387@caravaggio>
References: <20181022183656.4902-1-sameo@linux.intel.com>
	<CAFEAcA9s9hJch1YNtS-0CrL73FTK5nxEEXA-ZnZm+x8+Ov-ZHQ@mail.gmail.com>
	<20181023190843.GB8387@caravaggio>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 20:12:57 +0100
Message-ID: <CAFEAcA98gYKv3HbgkQd2CDd8CmmafrTqZSZGDktzLFcA8Zd+0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/27] ACPI hardware-reduced support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 October 2018 at 20:08, Samuel Ortiz <sameo@linux.intel.com> wrote:
> Hi Peter,
>
> On Tue, Oct 23, 2018 at 08:01:26PM +0100, Peter Maydell wrote:
>> Hi -- I'd appreciate it if you don't send pull-requests for
>> patch series. They show up in my queue of things to merge directly
>> into master otherwise. Just send them as a patch-series email with
>> a cover letter, please.
> Apologies, I did not know. I'll fix that with the next revision of
> this patch set.

No problem. You can give a git branch URL for reviewers to look
at if you think it's helpful; just avoid using the stock git
pull-request email wording about 'for you to fetch changes', because
that's what my email filters look for :-)

thanks
-- PMM
