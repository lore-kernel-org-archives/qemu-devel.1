Received: from eggs.gnu.org ([2001:4830:134:3::10]:49696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZpy-00011w-CV
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:55:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cdZpx-0002QI-8v
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:55:54 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35570)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cdZpx-0002Ph-2o
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 04:55:53 -0500
Received: by mail-wr0-x22e.google.com with SMTP id c4so8215438wrd.2
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 01:55:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1487006388-7966-1-git-send-email-quintela@redhat.com>
References: <1487006388-7966-1-git-send-email-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Feb 2017 09:55:31 +0000
Message-ID: <CAFEAcA-gQDCVK6hZ9X7B6YUxr_icsew=AUBiEW3OaxzsqbA0ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/12] Multifd v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 13 February 2017 at 17:19, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> [v4]
>
> - Address reviews
> - move synchronization to semaphores (faster).  Paolo suggestion
> - improvements overall (see invidiual patches)
> - fix all the checkpatch warnings
> - fix all [HACKS] except for one
> Please review.


Is this a patch series or a pull request? The subject line
says "PATCH" and the body says 'please review' but it's in
the form of a pull request email...

thanks
-- PMM
