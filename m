Received: from eggs.gnu.org ([209.51.188.92]:34928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjiub-00021H-BN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:59:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjiua-0002W4-As
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:59:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjiuZ-0002Nm-CV
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 05:59:08 -0500
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
	<b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
Date: Wed, 16 Jan 2019 11:58:56 +0100
MIME-Version: 1.0
In-Reply-To: <b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] HACKING vs. CODING_STYLE (was: Re: [PATCH] HACKING:
 Clarify the paragraph about typedefs)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 2019-01-11 11:38, Paolo Bonzini wrote:
[...]
> And, I would move it to CODING_STYLE since we are at it. :)

I just got some feedback in IRC already, and seems like I am not alone,
so let's discuss it here on the mailing list, too: What's the exact
difference between CODING_STYLE and HACKING? Some of the paragraphs in
HACKING sound rather mandatory and coding-style related, too...
Should we maybe merge the two files into one (e.g. called "CODING")?

 Thomas
