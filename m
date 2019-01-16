Received: from eggs.gnu.org ([209.51.188.92]:54465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjjHv-0001DA-8B
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:23:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjjHe-0003GD-H1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:23:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjjHe-0002x3-6T
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 06:22:58 -0500
References: <1547196148-12250-1-git-send-email-thuth@redhat.com>
	<b1db55de-6741-76c7-33b1-74fc2692b82c@redhat.com>
	<552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <37af0849-319b-9f38-547d-43b7032c045a@redhat.com>
Date: Wed, 16 Jan 2019 12:22:47 +0100
MIME-Version: 1.0
In-Reply-To: <552ac2db-6568-18f8-5397-a00c4b432df9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] HACKING vs. CODING_STYLE (was: Re: [PATCH]
 HACKING: Clarify the paragraph about typedefs)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 16/01/19 11:58, Thomas Huth wrote:
>> And, I would move it to CODING_STYLE since we are at it. :)
> I just got some feedback in IRC already, and seems like I am not alone,
> so let's discuss it here on the mailing list, too: What's the exact
> difference between CODING_STYLE and HACKING? Some of the paragraphs in
> HACKING sound rather mandatory and coding-style related, too...
> Should we maybe merge the two files into one (e.g. called "CODING")?

I think they should be merged, yes.  It doesn't have to be done
immediately though.

Paolo
