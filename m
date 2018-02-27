Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eqkmW-0005Bb-I6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eqkmV-0004YT-Qu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 14:19:20 -0500
References: <20180223112933.4135-1-mark.cave-ayland@ilande.co.uk>
	<CAFEAcA-6KuJe17cHNVUzaKT30uv7bBS52ctoNxS0u9Mfp_HtXg@mail.gmail.com>
	<7f968a6f-e647-e4dd-0ce5-54b2d63c6eb7@ilande.co.uk>
	<CAFEAcA83KywfXUqUJaFVRGGhUeC5hkjPG67oTaz0G=XzMHWNeg@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <47a562f8-f764-9b26-a563-857d3d94183c@ilande.co.uk>
Date: Tue, 27 Feb 2018 19:19:02 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA83KywfXUqUJaFVRGGhUeC5hkjPG67oTaz0G=XzMHWNeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] loader: don't perform overlapping address
 check for memory region ROM images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>

On 23/02/18 18:53, Peter Maydell wrote:

>> I can do, although I don't have any outstanding SPARC patches (just PPC ones
>> for the moment) so it would just be a single commit PR. Is that okay?
> 
> Yeah, it's less effort for me to apply a pull than a patch in some
> ways...

Done. I've also sent a v2 with your R-B added so your R-B tag should 
also appear in the patch when it eventually gets applied to qemu-stable.


ATB,

Mark.
